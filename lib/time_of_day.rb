require 'csv'

contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
)

def process_time(time)
    time = time.split(":")
end

def process_date(date)
    date = date.split("/")
    date[2].insert(0, '20')
    date
    #registrant_date = Date.new(date[2].to_i, date[0].to_i, date[1].to_i)
end

def get_time_and_date(date_and_time)
    date = date_and_time.slice(0, date_and_time.index(' '))
    time = date_and_time.slice(date_and_time.index(' ') + 1, date_and_time.length)
    date = process_date(date)
    time = process_time(time)
    formatted_time = Time.new(date[2].to_i, date[0].to_i, date[1].to_i,
                              time[0].to_i, time[1].to_i)
end

hours = []
day_of_week = []

contents.each do |row|
    date_and_time = row[:regdate]
    time = get_time_and_date(date_and_time)
    hours.append(time.hour)
    day_of_week.append(Date::DAYNAMES[time.wday])
end

def tally_hours(hours)
    most_hours = Hash.new(0)
    hours.reduce(most_hours) do |most, hour|
        most[hour] += 1
        most
    end
    most_hours
end

def tally_days_of_week(day_of_week)
    most_days = Hash.new(0)
    day_of_week.reduce(most_days) do |most, day|
        most[day] += 1
        most
    end
    most_days
end

most_hours = tally_hours(hours)
most_days = tally_days_of_week(day_of_week)

popular_hour = most_hours.select {|key, value| value == most_hours.values.max}
popular_day = most_days.select {|key, value| value == most_days.values.max}

puts "Most hours #{most_hours}"
puts "Days #{most_days}"
puts "Most popular hour #{popular_hour}"
puts "Most popular day #{popular_day}"

