ActiveRecord::Base.establish_connection

class Silhouette < ActiveRecord::Base
  
  belongs_to :mateial_bottom
  belongs_to :material_top
  #has_manyかもしれない
  belongs_to :material_person
  
end

class MaterialBottom < ActiveRecord::Base
 
  belongs_to :silhouette
  
end

class MaterialTop < ActiveRecord::Base
  belongs_to :silhouette
end

class MaterialPerson < ActiveRecord::Base
  
  belongs_to :silhouette
  
end