Type.delete_all
types = %i[Stickers Buttons Poster/Prints Pins Shirts Custome_others Dress Pants Outfit_dolls Hair_bows]
types.each do |type|
  Type.create!(name: type)
end

print "#{Type.count} types were created"