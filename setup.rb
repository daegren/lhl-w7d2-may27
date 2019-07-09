require 'active_record'
require 'pry'
require './models/artist'
require './models/album'
require './models/tag'
require 'faker'

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'postgres',
  password: 'postgres',
  database: 'w7d2_may27'
)

puts "Connected to db!"



ActiveRecord::Schema.define do

  create_table :artists, force: true do |t|
    t.string :name, null: false

    t.timestamps
  end

  create_table :albums, force: true do |t|
    t.string :title, null: false
    t.integer :year, null: false
    t.references :artist, null: false

    t.timestamps
  end

  create_table :tags, force: true do |t|
    t.string :name, null: false

    t.timestamps
  end

  create_join_table :artists, :tags, force: true

end

10.times do 
  Artist.create! name: Faker::Music.band
end

rock = Tag.create name: "Rock"
pop = Tag.create name: "Pop"

all_artists = Artist.all

rock.artists << all_artists.sample
rock.artists << all_artists.sample
rock.artists << all_artists.sample

pop.artists << all_artists.sample
pop.artists << all_artists.sample
pop.artists << all_artists.sample

binding.pry
