require "openai"
require "dotenv/load"

puts "Hello! How can I help you today?\n"
puts "--------------------------------------------------"

response = gets.chomp
puts "--------------------------------------------------"

if response == "bye"
  puts "Bye, have a good day!"
else
  while response != "bye"
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))
    message_list = [
      {
        "role" => "system",
        "content" => "You are a helpful assistant."
      },
      {
        "role" => "user",
        "content" => response
      }
    ]
    
    # Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )
    
    choices = api_response.fetch("choices")
    message = choices.at(0).fetch("message")
    content = message.fetch("content")
    message_list.push({"role" => "user", "content" => response})
    puts content
    puts "--------------------------------------------------"
    response = gets.chomp
    puts "--------------------------------------------------"
  end
  puts "--------------------------------------------------"
  puts "Bye, have a good day!"
end
