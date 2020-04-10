require 'base64'

system 'clear'

print 'Enter password to encrpyt: '
str = gets.chomp

system 'clear'
print 'Encoded password is: '
puts Base64.encode64(str)
