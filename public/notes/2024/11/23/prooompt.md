can you please fix spelling, grammar, and style as well as add punctutation where necessary and add paragraph by adding two line breaks between paragraphs? please output nothing but the response and add the result in three ticks like ```this``` 
this is part three of ??? 

um all right let's talk about one of our features that's maybe not quite there but it's very very ready I've been using it a lot yes um it is a feature that right now in net 9 it is only in preview and so a language version preview I don't mean net SDK preview I mean you can go into your project file you can use net9 ga uh the general release and uh you can specify Lang version preview to get access to this feature um and we going come back to why it's in preview and not part of C 13 proper absolutely but let's let's let's show that feature that feature is uh something that we've shown a number of times often with squiggles but it really is here now and it's the field keyword uh so the ability to within an auto property to access the backing field right something that you know you with a with an auto property there's always been this big Cliff you have to if you want to do various things like um you know in your Setter you just want to say trim that value that's coming into the string you know to before it gets set to the or or just lock on something before you do the mutation as in this case yeah and that results in a huge Cliff where you've now got to okay well if I want to do those things I now need to go declare a field I can't use an auto property anymore and I must specify both accessors even though I only wanted to fiddle with one of them absolutely so we're taking that Cliff away with the F keyword is something you can use to say in accessors and property accesses to say well I am an auto property I do have a generated backing field and field is how I access it yeah now this however I can still write an accessor manually if I want to if you want to this one actually does right now because it sets a field that's different from this which is now the backing field yes um and so it's so we're actually getting a warning here that we should be using field because the other accessor does so that helps me not make a mistake and make sure that I'm using this uh this the the backing field keyword as well the field keyword which is awesome and so now that map field isn't isn't needed up there you can see it's gray out up there we're not referencing anymore so so we just get a backing field of the same type as the property generated for us um now um it may be a little excessive that we're actually locking on get oh yeah so if we men the get access or as just return field yeah if we took out that lock if we wanted to take out that lock we could do so just like this because it's an auto property I used to think that auto properties had to have like a get and a set and semicolons no bodies and really what and I thought that's what made it an auto property at least when I looked at it but really what makes it an auto property is whether you created a you had to like have a back backing field or where the one was generated for you and so now Auto properties come in this like large variation of syntax that you can use to really you know kind of lots of ways that you can use to make your property experience much nicer and be more expressive um and um and just to Circle back to the uh to the preview flag to uh well we'll get there as well but just the uh the partial thing from before now we are actually writing the implementation as an auto property yeah so but but because it has it's an auto property where one of at least one of the accessors has a body yeah it it doesn't conflict with the definition definition implementation can be can we can tell those apart yes and it and because it acts as the field keyword only it is an auto property which is exciting so that is pretty cool but yeah we should talk about why why we didn't just ship it why didn't we ship it and why it's in preview right now um and the reason it's in preview is because this is a breaking change um in fact we've talked with customers uh who have said they've gone through their code bases and said I have a lot of Fe called field right maybe they're writing database schemas and they have an object hierarchy and they're talking about fields in their databases or maybe this is like it's an academic thing and it's like oh well I have a person that has a field of study or or it's a force field in physics or it's in Star Wars whatever yeah or agriculture like actually turns out that many fields have Fields yes um so um so it's a little bit of a breaking change to start saying well inside accessors it's now a keyword yeah so sometimes this now becomes a problem yeah if you had that feel and you were referencing that and so we decided we went through many alternative designs in this feature and we're like this is the best design and this is the one that we're going to be happy that we landed on like 10 years from now this is going to be right but in order to do that we have to do a little more of a breaking change to C than we usually do and so we we sat down and said okay now's the time for us to come up with a breaking change approach for C that if that we can use sparingly probably not even once every release though let's see um and so um you can see that warning you get there that's sort of like it's not we haven't really implemented that breaking change approach yet but it we're sort of on the way there yeah so so right now it says you can refer to the existing member you can use this dot field to access the field like you would normally if you had a parameter in a field that matched um or because this is a keyword the standard way in C to use a keyword as an identifier and refer to it is with an at yeah and so uh so this is kind of what we think you know this breaking change experience which would do some of this kind of work for you and fix up the code that you have so that it doesn't break with the addition of this keyword but it's probably worth mentioning if you say this. field that work two and the reason that works is that um field is only a keyword if it sort of occurs on its right so so we made the sort of blast radius if you will of the breaking chain as small as possible it's only when you use it as a variable name Standalone like if as if it was a parameter then it's a keyword yeah amusingly I'm getting a getting that warning back again because now I'm using a field out there called field but this one uses a backing field and so now I'm getting let's say it's kind of funny um but yeah that's so this is where we want to go with uh with field and we hope that it will be yeah you know ready to go um and and and we want it to be there for C 14 ready to go and we would like you all to to play with it a bit and for us to understand like are we are we as right as we think we are about making this breaking change and uh help us get the the the the tooling experience and everything right around it so that come C 14 we can now deal with this breaking change with confidence and everyone can Embrace this new cord all right okay we have one more thing to show yeah and um and that's we finally get to why this all is a ref struct yeah I know ref structs the thing that you know you write only if you're like David Fowler or stepen to or somebody like that right and but here we have them here I I rarely write them yeah but uh but you know sometimes I do and um one of the things that's interesting about this particular ref struct is that it has a dispose method yeah but it doesn't Implement I disposable itself yeah um and the reason for that is that ref structs you know that if I want to actually want to implement eye disposable on this and pass it to something that took I disposable net would insist on that being boxed into an object because it's destruct and then you know that an object that implements I disposable on the Heap but ref structs can't be Implement can't actually live on the Heap they can only live on the stack if you want to think about ref structs like your spans and read only spans are ref structs so they those kind of limitations they have to be on a they have to be on a stack they apply to all ref structs and therefore it would seem that implementing interfaces doesn't make sense because you can't convert to them anyway yeah but it does in fact make sense and we've now enabled it yes and of course it it finds here the the dispose method needed to implement the interface um but the but How do you use yeah how would we use it and we go back here and we see okay these methods actually take I disposable but they take it in as a constraint on T yes and this is where you can now use a ref struct that implements an interface and you can could con conceivably constrain it so I can go right here and I can type my file and all is good until it's not yeah but it's a start it's a good start um so yeah gener so generic uh kind of satisfying uh generic constraints is what interfaces are good for on ref struct that's how you can use them however type parameters by default they are not expected to be ref struct you you were never able to pass ref structs as type parameters and so they make assumptions they're like if you if you have a constraint that says that you implement I disposable well then you can convert to it and so we need to make say something about the type parameter that this type parameter actually does allow ref drugs um and the Syntax for that if you want to kind of Da very uh it's very surprising cry allows ref struct so so instead of a a a traditional constraint it's more like a a non straint right it's this uh you know kind of like a we call it an anti- constraint which seems like a double negative but it's really about this te does allow ref Str it allows extra things the and so that poses some limitations on the body of that method right because right here is a conversion to I disposable but it can't be converted to I disposable I can fix that I could use T right here and because T is constrained to I disposable and allows the rest struck I can still call dispose on it but I can't actually change you know convert it to an ey disposable because of that boxing issue and you've said that you care about not doing that in this method by saying I allow R structs exactly um now the other reason this works is because in net 9 we have added that particular uh um uh I guess anti con straint non straint whatever uh to um to a bunch of the core interfaces and delegate types right so this is this is this is implemented this is added sorry on ION numerable of T iable of T now implicitly allows can see it there in the hover it allows ref stru right there if I go over to otherwise we couldn't pass T to it yeah if I go over to you know source.net I can see you know right here in the right here in the S oh that's the wrong one right here in the source I can see it's right there yeah and likewise if I go and pick up something like action of te where you've had these delegates for a long time and now they've all been anteed to allow ref struck so that if you have something that you need to pass into you know some delegate somehow you don't have to go now you know you could do it with a ref struck but you had to go to find a new delegate the parameter type of that ref struct because you couldn't pass it to as you know t as a type parameter as a type argument and now we can and so it's yeah the I mean the the op shot of the story really is ref struct couldn't participate in any kind of abstraction that you couldn't any kind of code that was abstracted over multiple different kinds um you couldn't write you can use ref structs for it and now you can they can Implement interfaces and they can be allowed into generics and we do it all over the place so they kind of been this is also kind of like a first class thing that's happening um with ref structs that we didn't have before right and so it's enabl a bunch of cool scenarios and I think there's going to be a lot more to come in future. Nets so and with that we don't have any more to show you today yeah 