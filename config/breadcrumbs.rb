crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ"
  parent :root
end

crumb :product do |product|
  link product.name
  parent :root
end
