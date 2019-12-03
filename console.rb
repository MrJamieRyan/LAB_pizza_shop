require('pry')
require_relative('models/property_tracker')

property1 = PropertyTracker.new({
  'address' => '1 High Street',
  'value' => 200000,
  'number_of_bedrooms' => 2,
  'year_built' => '1992'
  })

  property2 = PropertyTracker.new({
    'address' => '2 Lower Street',
    'value' => 100000,
    'number_of_bedrooms' => 7,
    'year_built' => '1996'
    })

properties = PropertyTracker.all()

binding.pry
nil
