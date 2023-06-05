# Build Your Own Web Framework in Elixir

<a href="https://www.packtpub.com/product/build-your-own-web-framework-in-elixir/9781801812542"><img src="https://content.packt.com/B17548/cover_image_small.jpg" alt="Build Your Own Web Framework in Elixir" height="256px" align="right"></a>

This is the code repository for [Build Your Own Web Framework in Elixir](https://www.packtpub.com/product/build-your-own-web-framework-in-elixir/9781801812542), published by Packt.

**Develop lightning-fast web applications using Phoenix and metaprogramming**

## What is this book about?
Elixir's functional nature and metaprogramming capabilities make it an ideal language for building web frameworks, with Phoenix being the most ubiquitous framework in the Elixir ecosystem and a popular choice for companies seeking scalable web-based products. With an ever-increasing demand for Elixir engineers, developers can accelerate their careers by learning Elixir and the Phoenix web framework.

This book covers the following exciting features:
* Get a comprehensive understanding of the Phoenix framework built on Elixir
* Use metaprogramming to optimize your Elixir code and create high-performance web applications
* Explore web development fundamentals including the principles of HTTP and HTML
* Employ Elixir’s templating engine to dispatch requests to a controller and respond with dynamically generated HTML
* Improve the scalability and responsiveness of your web server by using OTP constructs

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1801812543) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" 
alt="https://www.packtpub.com/" border="5" /></a>


## Instructions and Navigations
All of the code is organized into folders. For example, Chapter02.

The code will look like the following:
```
defmodule ExperimentServer do
  # ..
  defp recv(connection_sock, messages \\ []) do
    case :gen_tcp.recv(connection_sock, 0) do
      {:ok, message} ->
      IO.puts """
      Got message: #{inspect(message)}
      """
      recv(connection_sock, [message | messages])
      {:error, :closed} ->
      IO.puts "Socket closed"
      {:ok, messages}
    end
  end
end
ExperimentServer.start(4040)
```

**Following is what you need for this book:**
This book is for web developers seeking to deepen their understanding of Elixir's role in the Phoenix framework. Basic familiarity with Elixir is a must.

With the following software and hardware list you can run all code files present in the book (Chapter 1-10).

### Software and Hardware List

This book relies on Elixir 1.11.x and Erlang 23.2.x. Ensure you have asdf or some other package
manager installed on your system. This will allow you to easily switch back and forth between
Elixir and Erlang versions. This book was tested on macOS and Linux, so you may experience some
inconsistencies when using Windows.


We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it](https://packt.link/jQVwi).



## Get to Know the Author
**Adi Iyengar**
 is a staff software engineer who has worked with Elixir since 2015. Over those years, he has worked across a wide array of applications and authored/contributed to several open source projects, including Elixir itself. Adi has also advised and continues to advise several start-ups on engineering and product, and helps them adopt Elixir and Phoenix to build functional and scalable minimal viable products (MVPs) from the ground up. He is passionate about mentoring and sharing his knowledge with others, which is why he actively mentors other engineers. He loves Elixir, functional programming, and test-driven development (TDD). Adi is also the co-host of the Elixir Mix podcast. When not coding, Adi can be seen playing billiards, playing the guitar, or breakdancing. Adi also spends a good amount of his time keeping up with new developments in particle physics.

Adi is also the co-host of the Elixir Mix podcast which is a weekly Elixir podcast where the panel discusses Functional Programming, the Elixir ecosystem and building real-world applications using Elixir based tools and frameworks.





