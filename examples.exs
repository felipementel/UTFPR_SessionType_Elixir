#!/usr/bin/env elixir

# Practical examples of send/receive in minimal session types
# Run with: mix run examples.exs

defmodule ExampleSessionType do

  def run_all do
    authentication_protocol()
    file_transfer_protocol()

    IO.puts("\n" <> String.duplicate("=", 50))
    IO.puts("Summary:")
    IO.puts("  Simple session types ensure send/receive alignment")
    IO.puts("  See also examples-violation.exs for incompatible cases")
    IO.puts(String.duplicate("=", 50) <> "\n")
  end

  defp print_header(title) do
    IO.puts("\n" <> String.duplicate("=", 50))
    IO.puts(title)
    IO.puts(String.duplicate("=", 50) <> "\n")
  end

  defp authentication_protocol do
    print_header("EXAMPLE: Authentication")

    client =
      SessionType.output(:username,
        SessionType.output(:password,
          SessionType.recv(:token, SessionType.end_session())
        )
      )

    show_pair(client)
  end

  defp file_transfer_protocol do
    print_header("EXAMPLE: File Transfer")

    client =
      SessionType.output(:filename,
        SessionType.recv(:file_content,
          SessionType.recv(:checksum, SessionType.end_session())
        )
      )

    show_pair(client)
  end

  defp show_pair(client) do
    server = SessionType.dual(client)
    IO.puts("Client: #{ProtocolChecker.format(client)}")
    IO.puts("Server: #{ProtocolChecker.format(server)}")
    IO.puts("\n Compatible? #{ProtocolChecker.compatible?(client, server)}")
  end
end

ExampleSessionType.run_all()
