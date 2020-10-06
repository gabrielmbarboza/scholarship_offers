json.name @course.name
json.kind @course.kind
json.level @course.level
json.shift @course.shift

json.university do
  json.name @course.university.name
  json.score @course.university.score
  json.logo_url @course.university.logo_url
end

json.campus do
  json.name @course.campus.name
  json.city @course.campus.city
end