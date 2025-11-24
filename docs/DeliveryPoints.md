# 1. Summary

The paper “FuSes: A Functional Language with Session-Typed Processes” presents a programming language that combines functional programming with session-typed concurrency. Session types define structured communication protocols between processes, ensuring that both sides follow the correct sequence of sends, receives, and terminations. This prevents common concurrency errors such as mismatched message types, unexpected message order, or deadlocks.

FuSes unifies two layers:

1.1. **A functional layer**, where processes can be constructed and manipulated as first-class values.
1.2. **A process layer**, where concurrent execution follows strict session-typed protocols.

The authors show how to safely generate, transform, and execute concurrent processes while guaranteeing protocol correctness. They formalize the language, prove type safety, and provide an implementation in OCaml demonstrating metaprogramming over session-typed processes.


# 2. Description of my own implementation

My implementation is a simplified proof-of-concept, PoC, of session types in Elixir, inspired by the ideas presented in FuSes.

Since Elixir is dynamically typed and does not enforce protocol correctness at compile time, I implemented a small library that models session types as explicit data structures and checks compatibility between two communicating processes.

The implementation includes:

2.1. A SessionType module

This module defines three constructs:

- output(T, next) — send a value of type T;
- recv(T, next) — receive a value of type T;
- end_session() — terminate the protocol.


It also includes SessionType.dual/1, which computes the dual protocol (send ↔ receive), similar to FuSes.

2.2. A ProtocolChecker module

This module validates whether two session types are compatible.
It compares a protocol with the dual of the other side and detects mismatches such as:

- Incorrect order of messages;
- Incompatible data types;
- Early termination.

2.3. Example scripts

Two runnable scripts demonstrate:

Successful protocol

Where client and server follow dual session types, such as:

````
Client: !⟨int⟩.?⟨string⟩.1
Server: ?⟨int⟩.!⟨string⟩.1
````

### Violation cases

Examples where communication fails:

- Mismatched data types;
- Inverted order of actions;
- Server expecting more steps than the client implements.

These examples simulate what FuSes enforces statically, but done here dynamically.

Together, the library and examples demonstrate how session-typed reasoning can be brought into Elixir, even without static types, and how protocol verification prevents concurrency errors.


# 3. Lessons Learned About Functional Programming

Working on this project for the introductory functional programming course helped me learn about object-oriented programming.

Functional programming using Elixir has a very different way of writing (compared to .NET/C# or Java, which are the languages ​​I know best). Functions that we could use lambdas or loops like for or while are easily implemented with structures inside methods with the def prefix.

Elixir doesn't have any strongly typed data structures, so we don't need to create a type to assign values, which makes the language more flexible.

In addition to studying in class, I did some separate studies to understand and implement some features, and it was quite challenging.

In November, I participated in the Elixir Curitiba event, which broadened my horizons and helped me learn more not only about Elixir, but also about Erlang and BEAM – and understand a bit about OTP, how Elixir uses it to simplify the access (for example, use mix new to create a new project) and why this ecosystem is so performant for concurrent systems – including zero downtime for updates in production environments.

It was a big challenge to do this project, and I enjoyed learning more about Elixir – my next challenge will be to build an API using Phoenix.
