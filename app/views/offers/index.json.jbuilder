json.array! @offers do |offer|
  json.full_price offer.full_price
  json.price_with_discount offer.price_with_discount
  json.discount_percentage offer.discount_percentage
  json.start_date date_format(offer.start_date)
  json.enrollment_semester offer.enrollment_semester
  json.enabled offer.enabled

  json.course do
    json.name offer.course.name
    json.kind offer.course.kind
    json.level offer.course.level
    json.shift offer.course.shift
  end
  
  json.university do
    json.name offer.course.university.name
    json.score offer.course.university.score
    json.logo_url offer.course.university.logo_url
  end

  json.campus do
    json.name offer.course.campus.name
    json.city offer.course.campus.city
  end
end