require 'CSV'

contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
)

contents.each do |row|
    