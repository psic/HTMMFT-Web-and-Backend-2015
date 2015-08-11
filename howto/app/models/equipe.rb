class Equipe < ActiveRecord::Base
has_many :joueurs
belongs_to :club
end
