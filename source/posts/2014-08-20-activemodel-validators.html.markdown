---
title: ActiveModel validations
date: 2014-08-20 00:44 UTC
tags: rails, learning
author: svankmajer
---

Yesterday, I fired up a console and started to code a [breakable toy](http://chimera.labs.oreilly.com/books/1234000001813/ch05.html#breakable_toys) to improve my TDD skills, which I haven't yet exercised properly. It's called Luego ('Later' in Spanish) and is, simply, a Pocket clone. I love [Pocket](https://getpocket.com/about). Last year, I was in the top 5% of readers in Pocket. I expect similar results for this year. It is an indispensable tool to me, like [Evernote](https://evernote.com/) and [Basecamp](https://basecamp.com/), two other great products I use daily. So I wanted to think about how would I make my own Pocket, putting in practice what I've learned so far about Test-Driven Development. 

I sat down for a few hours and wrote down how Pocket could be designed at a ridiculously high level, in a way that would permit a modest hacker to implement a bare-bones but fully-functioning prototype as a moderate intellectual challenge.

Now, I would've loved to run an adapted version of a [Product Design Sprint](http://robots.thoughtbot.com/the-product-design-sprint) for this side-project, but I didn't, because I thought it would be too much. It would've been. So, just pencil and paper, lots of fresh water and winter sunlight, and the unstoppable purring of my cats. It was a tough but pedagogical experience, and I think it has greatly improved my web application development process.

I know is hard to conceive at this point, but this blog post isn't about the whole design & implementation process (mayhaps in the next post, who knows) but about something I've learned about custom validations of ActiveRecord models.

In a nutshell, model-level ActiveRecord validations check your object's state before it hits the database to ensure only valid data gets saved. This means, merely, that when you run `save` on your ActiveRecord model instance, all configured validations are triggered, returning true if all of them passed or false if they didn't; if they didn't, you call call `errors.messages` to see a detail of those errors. As you can see, they are very useful, very low cost (i.e. really easy to test and maintain) and really easy to use.

Rails has lots of common, pre-defined validation helpers (like `presence`, `uniqueness`, `length`, etc.), but also, gives you the possibility to define your own custom validators and validation methods. I always used pre-defined validators in my previous Rails applications, but I never really needed a custom solution for some kind of complex validation... until now (or that what I thought). So I went to the [Rails guides](http://guides.rubyonrails.org/) which are excellent resources and started reading about the different ways I could implement them. 

Rails offers two ways to implement custom validation: **custom validators** and **custom validation methods**. Custom validators are classes that extend `ActiveModel::Validator` and implement a `validate(record)` method. You can use this validator calling `validates_with :my_custom_validator` in your model class. Here is a code sample:

```ruby
class MyCustomValidator < ActiveModel::Validator
  def validate(record)
    # this is where you perform your validation
  end
end
```

So, in your model class, you call the validator like this:

```ruby
class  < ActiveRecord::Base
  include ActiveModel::Validations

   # other validations
   validates_with :my_custom_validator

   # the rest of your awesome class
end
```

Neat, eh?

You could add your custom validators in `app/validators` and they will be automatically loaded on start-up.

You could also check specific attributes of your records using `ActiveModel::EachValidator` which must implement a `validate_each(record, attribute, value)` method. Or, you could use a custom validation method registering it with `validate` like this:

```ruby
class Order < ActiveRecord::Base
  validate :inside_opening_hours?

  def inside_opening_hours?
     # here you perform your needed validations
     # ... add some errors if conditions are not met!
     errors.add(:taken_at, "can't take order this late")
  end
end
```

You should totally check the [Active Record Validations](http://guides.rubyonrails.org/active_record_validations.html) guide in the Rails Guides website. I wholeheartedly recommend it.
