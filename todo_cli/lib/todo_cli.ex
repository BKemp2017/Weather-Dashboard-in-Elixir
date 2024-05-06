defmodule TodoCli do
  def start do
    process_command([])
  end

  defp process_command(tasks) do
    IO.puts("Enter a command (new, list, quit):")
    command = IO.gets("> ") |> String.trim()

    case command do
      "new" -> add_task(tasks)
      "list" -> list_tasks(tasks)
      "quit" -> :ok
      _ ->
        IO.puts("Unknown command")
        process_command(tasks)
    end
  end

  defp add_task(tasks) do
    IO.puts("Enter a task description:")
    description = IO.gets("> ") |> String.trim()
    id = Enum.count(tasks) + 1
    new_task = %TodoTask{id: id, description: description, completed: false}
    updated_tasks = [new_task | tasks]
    IO.puts("Task added: #{description}")
    process_command(updated_tasks)
  end

  defp list_tasks(tasks) do
    Enum.each(tasks, fn task ->
      IO.puts("ID: #{task.id}, Description: #{task.description}, Completed: #{task.completed}")
    end)
    process_command(tasks)
  end
end
