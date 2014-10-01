require 'httparty'
require 'csv'
require 'json'
require 'securerandom'
require 'redis'
require 'hiredis'

class Exoplanets
  include HTTParty
  base_uri 'exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI'

  def self.table(table, options = {})
    puts "Getting Data from Caltech about #{table}..."
    data = get('/nph-nstedAPI', query: { table: table })
    data = CSV.parse(data).to_json

    puts "Parsing the data..."
    ep_array = JSON.parse data
    columns = ep_array.shift
    rows    = ep_array

    column_indexes = {}
    columns.each_with_index do |column, index|
      column_indexes[index] = column
    end

    print "Saving the data"
    exoplanets_hash = {}
    rows.each_with_index do |row, row_index|
      row_uuid = SecureRandom.uuid
      exoplanet_hash = {}
      row.each_with_index do |data, index|
        exoplanet_hash[column_indexes[index]] = data
      end
      exoplanets_hash[row_uuid] = exoplanet_hash
      print '.' if row_index % 100 == 0 and row_index != 0
    end
    puts ''

    puts "Storing the data..."
    case options[:storage]
    when nil, :json
      file = File.new "./bin/#{table}.json", 'w+'
      file.puts exoplanets_hash.to_json
      file.close
    when :redis
      redis = Redis.new(driver: :hiredis)
      redis.set table, exoplanets_hash
    end
  end

  def self.all(options = {})
    tables = [
      # Confirmed Planets
      :exoplanets,

      # Kepler Objects of Interest (KOI)
      :cumulative, :q1_q16_koi, :q1_q12_koi, :q1_q8_koi, :q1_q6_koi,

      # Threshold-Crossing Events (TCEs)
      :q1_q16_tce, :q1_q12_tce,

      # Kepler Names, Kepler Stellar Properties and Kepler Time Series
      :keplerstellar, :q1_q16_stellar, :q1_q12_stellar, :keplernames
    ]

    tables.each do |table_name|
      send :table, table_name, options
    end
  end
end
