ActiveRecord::Base.establish_connection

class Contribution < ActiveRecord::Base
    
  belongs_to :silhouette
  belongs_to :like
  has_many :comments
  
end

class Silhouette < ActiveRecord::Base
 
  belongs_to :contribution
  #一つの行にbottomとtopとpersonの素材が入っているからそれを取り出すだけ,
end

class Like < ActiveRecord::Base
  
  belongs_to :Contribution
  
end

class Comment < ActiveRecord::Base
  
  belongs_to :contribution
  
end