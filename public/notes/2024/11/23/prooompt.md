can you please fix spelling, grammar, and style as well as add punctutation where necessary and add paragraph by adding two line breaks between paragraphs? please output nothing but the response and add the result in three ticks like ```this``` 
this is part one of ??? 


ini





I'm Matt Ston. I'm an architect at Microsoft, and I'm also the lead designer of CP. 

Uh, I'm Dustin Campbell. I'm an architect on .NET tooling and also a member of the C language design team. I work a lot with this guy. 

Today, we have .NET 9 coming out, which also means that we have C# 13 meeting the world today. We're here to tell you a little about what's in this version of C#. We want to start by taking you on a very brief tour of how you can stay updated on what's going on with C#. Like everything else here, it's open source. 

I've got a couple of things up here on my laptop that should show you a few ways to get involved or stay engaged if you're new to the C# universe. We have a few examples of ways to do that at various levels of interest. 

This first thing is learn.microsoft.com, which has the "What's New in C# 13." If you want to find out what's in the product for C# 13 and get documentation on these features and how they play in, all of it is here. This is a great way to get an overview of the languages that have shipped. 

However, language features that have shipped are just the beginning. As we go, the C# 14 cycle essentially starts now, and we tend to put language features out in preview. We actually have one that we'll be showing today that's already going to be in preview. We try to keep the "What's New" page updated, even with preview documentation of preview features, so it is a good place to keep an eye on C# as it evolves over the year. 

Another spot you can look at is on GitHub in the Roslyn repo, which is where the C# and Visual Basic compilers and IDE stacks live. This is the language feature status page in the docs folder, where you can see the nitty-gritty on who's working on what and what we're looking at for C# 13, as well as what's happening next. If you're interested in seeing branches merge, this is where to go. 

The working state is everything that we currently have engineering activity on. As the C# language design team, we work on even more things that haven't yet started being implemented. The place to go if you really want to engage with the C# design is our separate repo, C# Lang, which is again in the .NET Foundation on GitHub. This is where notes from our language design meetings are posted, where proposals are made, and where issues and discussions happen. This is also an active development area, though it's not necessarily code development; it's where the nitty-gritty of the language design itself occurs. If you want to get involved in some way, provide feedback, or discuss with the team or other like-minded folks, then this is the place to go for that. 

There is quite a lot of community contribution in this repo as well, particularly regarding the design of C# as opposed to the implementation we saw before. 

Absolutely, but I guess we're here to look at code. Let's talk about many of the features in C# 13. By "features," I mean that some of them really feel like just bug fixes. We're going to show some of the more interesting ones, but as you can see on that language status page and the "What's New," there's plenty. 

In a way, we've been looking at the features that landed in C# 13, and it feels very much like, almost not necessarily small features, but features that might feel smaller. They are there to genuinely improve the consumption of code, making it easier and ensuring you're doing the right things. They provide type authors and library authors with the right tools they need to help you get on the right path for consuming APIs. 

There is a theme to it, even though it feels a little grab-baggy. I like the idea that it's very light on new syntax, but there's a lot of semantics behind familiar syntax. 

Starting with this one here: params. Yes, this has been in the language since C# 10. Params has been around forever, and it's always been about arrays. You can have a params array, which means that the call up there on the first line packages all the arguments for that parameter into an array that gets created on the spot and passed on to the method. 

Almost immediately after this shipped, we wondered why we couldn't do params with IEnumerable. Then .NET 2 came out with generics, and we thought, "Well, why can't I do one with params IEnumerable<T>?" That's been a long-standing request. 

To be clear, if you want to have a general API that takes all kinds of collections but also uses params, you need two overloads: the general one that takes IEnumerable<T> and then an array one that is params because only arrays can be params. You can kind of guess where we're going with this. 

This gives you

the ability to have something where, if you've got a list in hand, you can pass that, and it will make its way into the IEnumerable<T>. In the other overload, you can pass a list of arguments, and they'll get into the params. Often, this is implemented in a way that you wouldn't normally do; you usually take the params one and use that to call the IEnumerable<T> one. However, it seems like every API that wants to expose params ends up doing something like this as well. 

We've had it on our list for well over a decade to do something about that. But then there's the question: if we do params for IEnumerable, what about other types? People will immediately be like, "Okay, params for other things, right?" So we kind of left it alone. 

Last year, when we were releasing C# 12, a very consequential feature came out: collection expressions. My favorite feature in years! To be able to surround this with brackets and just say this is now a collection that is not opinionated on the type of that collection is a game changer. It decides what the collection is going to be based on its surroundings. 

In this case, we could pass it in here and get a result that looks very similar to passing params, but with just these square brackets. The big difference with collection expressions is that you can pass them to almost any collection type. There are standard ways that they will work, and they will function like old-fashioned collection initializers if you don't do anything else. However, you can also set things up in your API to tell it how to create your collection in a smart way. 

The compiler specializes in a lot of common types, and it can create all kinds of different collections from the same syntactic expression. It does a really good job at creating efficient implementations of interfaces and that kind of stuff. 

Now, in this case, overload resolution will make it so it calls the array still. But if I delete that, I can do so now because I've got that collection expression up there. The compiler will generate a type that's very efficient and implements IEnumerable<T> for you, so you don't have to go and say, "I'm newing up a list" or "I'm newing up something else" to pass in here. Instead, it will create something that implements IEnumerable<T> so that it can be passed here successfully and efficiently. 

That little extra step we took in C# 13 is that now we have machinery to create all kinds of different collections from a list of elements. Couldn't we just do that with params as well? Could we allow params on all those collection types and have it do the same thing? It turns out we can! 

So, this is, of course, legal in C# 13. We have params for all sorts of things, essentially for the things that you can create with collection expressions. We know how to build that machinery now, so if I delete these brackets, it works just fine, and it's going to do essentially the same thing under the hood as if you passed in a collection expression. 

You can think about it as params being the compiler putting those square brackets around the elements that you're listing as arguments. Those two features are very closely connected. 

In this case, because it's IEnumerable<T>, we're going to be allocating something under the hood. There are cases where you don't want that, and you might wonder what other things we could do with params. If I wanted to do something a little more efficient using some of the span-based types that we have, that's also allowed. 

I could type Span<T> in here, and that works. Or I could use its read-only cousin to pass in arguments that could be from some heap-allocated type, from an array, or even just allocated on the stack. This could point to memory on the stack, so that you're not making any objects to pass something in that can then be iterated over like this. 

This is probably the second longest request we've had for params: support for span types. The compiler can choose to allocate that span on the stack, and when it does, no memory is wasted. It's actually very similar to if you had all those parameters individually in your signature; they would also have gone on the stack. 

From a memory layout and performance perspective, this mirrors multiple parameters the best. There's another piece of this that I think is really interesting: overload resolution would like to say that in this case, ReadOnlySpan<T> is a better overload because it would implement IEnumerable<T>. However, it can't, and so we end up picking the ReadOnlySpan<T> type here. 

This is part of another feature of C# 13 that is somewhat under the hood. You won't see it pop up, but it will help you do the right thing. We essentially embarked on a new story arc, if you will, in C# for spans—making spans first-class citizens. 

Even though spans have been around for a long time, many people find them challenging due to their restrictions, as they have to live on the stack. As a result, a lot of developers don't use them directly. We want to make it so that you can get a lot of benefits from spans without having to understand too much of that machinery. 

However, the language itself has kept spans at arm's length for a bit. There are conversions from arrays to spans to ReadOnlySpans, but they haven't been fully integrated into the language. This means spans haven't felt completely integrated into the language. 

We have started down this path, and there will be more in C# 14 to make spans first-class citizens. The down payment on that in C# 13 is that we make spans better than arrays in all the interfaces implemented by arrays in overload resolution. It is generally a more efficient way of doing things, and it makes sense. 

Another thing about params and collections is that we can do IEnumerable<T> and ReadOnlySpan<T>, but we can also work with many other types. There are ways with collection expressions to expose them in such a way that the collection expressions know how to build them. 

One of the types that has been challenging is the mutable array. I even showed an analyzer on this years ago in a "What's New in C#" talk. The idea is that a mutable array is one of those types we use a lot, but it can't be used with the old-style collection initializer. 

This has been a long-standing limitation, and we are looking to address it. The goal is to make it easier for developers to work with mutable arrays in a way that feels natural and integrated into the language. 

As we continue to evolve C#, we are committed to listening to the community and addressing these long-standing requests. We want to ensure that the language remains powerful, flexible, and easy to use for all developers. 

In summary, C# 13 introduces several exciting features that enhance the language's usability and performance. From improved support for params and spans to the introduction of collection expressions, we are making strides toward a more efficient and developer-friendly experience. 

We encourage everyone to explore these new features and provide feedback as we continue to refine and improve the language. Thank you for joining us today, and we look forward to seeing how you leverage these new capabilities in your projects!
