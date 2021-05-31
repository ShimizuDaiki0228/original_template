ActiveRecord::Base.establish_connection

class Contribution < ActiveRecord::Base
    
  belongs_to :silhouette
  belongs_to :like
  belongs_to :comment
  
end

class Silhouette < ActiveRecord::Base
 
  belongs_to :contribution
  
end

class Like < ActiveRecord::Base
  belongs_to :Contribution
end

class Comment < ActiveRecord::Base
  
  belongs_to :contribution
  
end