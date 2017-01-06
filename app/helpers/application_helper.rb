module ApplicationHelper
  def gravatar_for(user, options = {})
    options[:alt] = user.username
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{options.delete(:size) { 40 }}", options
  end
end
