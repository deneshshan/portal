defmodule Portal.Door do
  @doc """
  Starts a door with given `color`.

  The color is given as a name so we can identify
  the door by color name instead of using a PID
  """
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end


  @doc """
  Get the data currently in the `door`.
  """
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Pushes `value` into the door.
  """
  def push(door, value) do
    Agent.update(door, fn list -> [value|list] end)
  end

  @doc """
  Pops a value from the `door`.
  """
  def pop(door) do
    Agent.get_and_update(door, fn
      []    -> {:error, []}
      [h|t] -> {{:ok, h}, t}
    end)
  end
end
