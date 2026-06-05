# 📚 Reading Assignments — Summary Notes

---

## 1. Active Record Pattern vs. Repository Pattern

The core idea here is about how your application talks to the database — and how much that relationship bleeds into your business logic.

**Active Record** bundles data persistence and business logic together in a single object. The object *is* the database row. Rails uses this pattern heavily, and for simple apps it's genuinely great — you get CRUD for free and everything lives in one place. The problem shows up as the app grows. That `User` model starts handling validations, soft deletion, notifications, external service calls, and god knows what else. You end up with a "god class" that's 1000+ lines and terrifying to touch, because changing one thing might break something completely unrelated.

**Repository Pattern** takes a different approach. It says: your domain object should only know about business rules — nothing about databases. A separate `UserRepository` class handles all the persistence stuff. This separation means you can swap out your database (say, from MySQL to Redis) by writing a new repository without touching the `User` domain class at all. Testing also becomes much easier because you can test your domain logic with plain Ruby, no database setup needed.

> **Key takeaway:** Active Record is perfect when your app is simple and you want to move fast. Repository Pattern pays off when you're building something complex, where business rules evolve a lot and testability matters. The moment your models start feeling bloated, that's usually the sign to consider separating concerns.

---

## 2. Rails Migrations

A migration in Rails isn't about moving data somewhere — it's about changing the *structure* of your database in a safe, version-controlled way. Think of it like Git, but for your database schema.

When you create a new model, you typically generate a migration file alongside it using `rails generate model`. That file gets a timestamp in its name so Rails can track which migrations have already run. Running `rails db:migrate` applies all the pending ones, and Rails handles writing the actual SQL under the hood — you just write Ruby.

What makes migrations powerful isn't just the convenience. It's the reversibility. Made a mistake? Run `rails db:rollback` and you're back to where you were. This is a lifesaver during early development when you're still figuring out your schema. And because migration files stack up over time, you can blow away your database completely, run all the migrations again, and get back to the exact same structure — whether that's on your laptop or a production server.

One important convention: you don't undo a migration once things are live and stable. Instead, you create a *new* migration to remove or rename whatever you don't need anymore. This keeps the history clean and protects the database.

> **Key takeaway:** Migrations are your database's changelog. They let you evolve your schema incrementally without writing raw SQL, keep your changes reversible during development, and make database setup reproducible across any environment.

---

## 3. Ruby Object Model

This article answers a question that sounds simple but goes surprisingly deep: what does it actually mean for Ruby to be "fully object-oriented"?

Everything in Ruby — strings, integers, arrays, even classes themselves — is an object. And every object belongs to a class hierarchy that Ruby calls the **ancestor chain**. When you call a method on an object, Ruby doesn't just look in that object's class — it walks up the ancestor chain until it finds the method, or raises a `NoMethodError` if it never does.

The hierarchy in Ruby goes like this:

```
your class → included modules → parent class → Object → Kernel → BasicObject
```

- `BasicObject` is the absolute root of everything.
- `Kernel` is a module that provides most of the common methods you use daily (like `puts`).
- `Object` sits on top of `Kernel` and acts as the default parent for any class you define.

There's also the `main` object — when a Ruby program starts, Ruby creates this top-level `main` object as an instance of `Object`. Any code you write outside of a class or module runs in the context of `main`. This is why you can call `puts` anywhere without referencing a class.

> **Key takeaway:** Understanding the ancestor chain is essential for debugging unexpected method behavior in Ruby. When a method gets called, Ruby follows a very specific lookup path — and knowing that path explains a lot of what feels like "magic" in Ruby and Rails.

---

## 4. Ruby Modules

Modules in Ruby serve two main purposes: **namespacing** and **composition via mixins** — and both of them solve real problems.

As a **namespace**, a module acts like a container that groups related classes and constants together to avoid naming conflicts. For example, `Rails::Application` won't clash with some other gem's `Application` class because it's scoped inside the `Rails` module. You access it with the `::` operator.

As a **mixin**, a module lets you share behavior across classes without inheritance. Since Ruby doesn't support multiple inheritance, mixins are the idiomatic way to compose functionality. You have three keywords to work with:

| Keyword | What it does |
|---------|-------------|
| `include` | Adds module methods as **instance methods**, inserted into the ancestor chain *after* the class. Last included appears first in the chain. |
| `prepend` | Like `include`, but inserts the module *before* the class itself. The module's method wins even if the class defines the same one — useful for wrapping behavior. |
| `extend`  | Adds module methods as **class methods** by inserting the module into the singleton class's ancestor chain. |

> **Key takeaway:** Modules are one of Ruby's most powerful tools for keeping code organized and avoiding inheritance nightmares. Prefer composition over inheritance — and when you need to share behavior across unrelated classes, reach for a module. The difference between `include`, `prepend`, and `extend` comes down to *where* in the ancestor chain the module lands and whether you want instance or class-level methods.
