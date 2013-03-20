require File.dirname(__FILE__) + '/Generation'
require File.dirname(__FILE__) + '/Gene'


TargetVal = 499
EvalBase = 1000
$q = [31,41,59,26,53,58,97,93,23,84,-62,-64,-33,-83,-27,-95,-2,-88,-41,-97]
Poolsize = 30
DataNo = 20

ave_file = File.open("ave.txt","w")
ave_file.close
elite_file = File.open("elite.txt","w")
elite_file.close

def init_generation(poolsize,data_no)  
  generation = Generation.new
  for i in 0.step(poolsize -1, 1) do   
    array = [data_no]
    for j in 0.step(data_no -1 , 1) do      
      bit = Random.rand(2)
      array[j] = bit      
    end
    gean = Gene.new
    gean.data = array
    generation.add_gene(gean)    
  end
  return generation
end

def evalfit(sum)  
  eval = EvalBase - (TargetVal - sum).abs
  return eval  
end

def calc_sum(gean) 
  sum = 0
  for col_no in 0.step(gean.data.size - 1 , 1) do
    flg = gean.data[col_no]
    if flg == 1 then
      val = $q[col_no]
      sum += val
    end    
  end  
  return sum  
end

def calc(generation)    
  for i in 0.step(generation.gene_size - 1, 1) do      
    gean = generation.get_gene(i)
    gean.val = calc_sum(gean)
    gean.eval = evalfit(gean.val)       
  end  
end

def mutation(generation)
  for i in 0.step(generation.gene_size - 1, 1) do      
    gene = generation.get_gene(i)
    for j in 0.step(gene.data.size - 1, 1) do 
      if Random.rand(100) <= 5
        gene.data[j] = gene.data[j]==1 ? 0 : 1
      end
    end        
  end  
    
end

generation = init_generation(Poolsize,DataNo)

for gen_no in 0.step(100,1) do
  calc(generation)
  next_generation = generation.copy()
  
  for i in 0.step(Poolsize/2 -1 ,1)
    f_gene = generation.select()
    m_gene = generation.select() 
  
    g1 = next_generation.get_gene(i * 2)
    g2 = next_generation.get_gene(i * 2 + 1)
    Generation::crossing(f_gene,m_gene,g1,g2)
  end  
  mutation(next_generation)
  puts "generation : #{gen_no}"
  generation.write_summury()
  generation = next_generation
end



