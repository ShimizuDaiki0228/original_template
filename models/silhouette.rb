ActiveRecord::Base.establish_connection

class Silhouette < ActiveRecord::Base
  
  has_many :mateial_bottoms
  has_many :material_tops
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