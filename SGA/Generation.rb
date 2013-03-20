require File.dirname(__FILE__) + '/Gene'

class Generation
  
  def initialize()
    @gene_list = Array.new
  end
  
  def gene_list=(value)
     @gene_list = value
  end   
  
  def copy()
    g = Generation.new
    g.gene_list = @gene_list
    return g
  end
  
  def gene_size
    return @gene_list.size
  end 
  
  def add_gene(gene)
    @gene_list << gene
  end
  
  def get_gene(i)
    return @gene_list[i]
  end
  
  def select()
    max_gene = nil
    
    for i in 0.step(3,1) do
      r = Random.rand(@gene_list.size)
      gene = @gene_list[r]       
      if max_gene == nil 
        max_gene = gene
      elsif  max_gene.eval < gene.eval 
        max_gene = gene      
      end      
    end    
    
    return max_gene   
  end
  
  def Generation.crossing(f_gene,m_gene,gene1,gene2)
    col_size = f_gene.data.size    
    for i in 0.step(col_size - 1,1)
      if i < col_size / 2
        gene1.data[i] = f_gene.data[i]
        gene2.data[i] = m_gene.data[i]
      elsif 
        gene2.data[i] = f_gene.data[i]
        gene1.data[i] = m_gene.data[i]
      end
    end
  end
  
  
  
  def write_summury()     
    write_stats()
    for i in 0.step(self.gene_size - 1, 1) do      
      gean = self.get_gene(i)      
      puts gean.to_s     
    end  
  end
  
  def write_stats()
    ave = 0.0
    max = nil
    for i in 0.step(self.gene_size - 1, 1) do      
      gean = self.get_gene(i)
      ave += gean.eval      
      if max == nil
        max = gean.eval
      elsif max < gean.eval
        max = gean.eval
      end
    end  
    ave = ave / self.gene_size  
    elite = get_elite()  
    ave_str = "Average : #{ave}  max : #{max}" 
    elite_str = "elite : #{elite.to_s}" 
    puts ave_str
    puts elite_str
    
    ave_file = File.open("ave.txt","a+")
    ave_file.puts(ave_str)
    ave_file.close
    elite_file = File.open("elite.txt","a+")
    elite_file.puts(elite_str)
    elite_file.close
  end
  
  def get_elite()
    elite = nil
    @gene_list.each do |gene|
      if elite == nil
         elite = gene
       elsif elite.eval < gene.eval
         elite = gene
       end
    end
    return elite
  end
  
end

  
