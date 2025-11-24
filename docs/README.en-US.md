# UTFPR IFP Fuses (Simplified)

This repository now demonstrates **only two basic session-type protocols** in Elixir:

1. Client sends an integer and then receives an integer from the server.
2. Client receives an integer first and then sends another one back.

The goal is to highlight the `send` ↔ `receive` duality without advanced operators or multiple branches.

## Structure

- `lib/session_type.ex`: builders for `:send`, `:receive`, `:end`, plus `dual/1`.
- `lib/protocol_checker.ex`: checks whether two protocols are compatible (dual pairs) and formats them for display.
- `main.exs`: runs the two demos with console output.
- `test/utfpr_ifp_fuses_test.exs`: ensures construction, duality, compatibility, and formatting (TBD in PT doc).

## How to run

```bash
mix run main.exs
```

Expected snippet:

```
============================================================
DEMONSTRATION: Session Types
============================================================

------------------------------------------------------------
EXAMPLE 1: !⟨int⟩ followed by ?⟨string⟩
------------------------------------------------------------
Client = !⟨:int⟩.?⟨:string⟩.1
Server = ?⟨:int⟩.!⟨:string⟩.1
Compatible? true

------------------------------------------------------------
EXAMPLE 2: ?⟨bool⟩ followed by !⟨ack⟩
------------------------------------------------------------
Server = ?⟨:bool⟩.!⟨:ack⟩.1
Client = !⟨:bool⟩.?⟨:ack⟩.1
Compatible? true

============================================================
Demonstration completed.
============================================================
```

## Success examples

```bash
mix run examples.exs
```

Summary expected:

```
==================================================
EXAMPLE: Authentication
==================================================

Client: !⟨:username⟩.!⟨:password⟩.?⟨:token⟩.1
Server: ?⟨:username⟩.?⟨:password⟩.!⟨:token⟩.1

✓ Compatible? true

==================================================
EXAMPLE: File Transfer
==================================================

Client: !⟨:filename⟩.?⟨:file_content⟩.?⟨:checksum⟩.1
Server: ?⟨:filename⟩.!⟨:file_content⟩.!⟨:checksum⟩.1

✓ Compatible? true

==================================================
Summary:
	Simple session types guarantee send/receive alignment
	See examples-violations.exs for incompatible cases
==================================================
```

## Protocol violation examples

```bash
mix run examples-violations.exs
```

Summary expected:

```
==================================================
Compatibility Violations
==================================================

--------------------------------------------------
CASE 1: Client sends :int but server expects :string
--------------------------------------------------
Client = !⟨:int⟩.1
Server = ?⟨:string⟩.1
Compatible? false

--------------------------------------------------
CASE 2: Client sends then receives, server also wants to send
--------------------------------------------------
Client = !⟨:ping⟩.?⟨:pong⟩.1
Server = !⟨:status⟩.?⟨:ack⟩.1
Compatible? false

--------------------------------------------------
CASE 3: Client ends before sending the second value
--------------------------------------------------
Client = !⟨:token⟩.1
Server = ?⟨:token⟩.?⟨:confirmation⟩.1
Compatible? false

==================================================
End of compatibility violation examples
==================================================
```

- NOTE **About the final delivery** → [`docs/DeliveryPoints.md`](docs/DeliveryPoints.md). There is an extra document detailing the custom implementation inspired by FuSes and the lessons learned.
