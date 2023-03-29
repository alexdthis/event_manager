require 'csv'

contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
)

def clean_phone_number(homephone)
    homephone.to_s.gsub(/[ ()-.]/, '')
end

def good_or_bad_number(clean_number)
    arrayed_number = clean_number.split('')
    case arrayed_number.size
    when 11
        if arrayed_number.first == 1
            result = 'Good Number' 
            arrayed_number.shift
        else
            result  = 'Bad Number'
        end
    when 10
        result = 'Good Number'
        arrayed_number
    else
        result = 'Bad Number'
    end
    if result == 'Good Number'
        arrayed_number
    else
        'Bad Number'
    end
end

contents.each do |row|
    phone_number = clean_phone_number(row[:homephone])
    output_phone = good_or_bad_number(phone_number)
    final_phone = 'Bad Number'
    if output_phone != 'Bad Number'
       final_phone = output_phone.insert(3, '-').insert(7, '-').join()
    end
    puts "#{row[:first_name]} #{final_phone}"
end



