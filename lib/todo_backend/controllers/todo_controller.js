import Todo from "../models/todo_model.js";

let todos = [];
const createTodo = async (req, res) => {
  const { todo, description } = req.body;

  if (!todo || !description) {
    return res
      .status(400)
      .json({ error: "Todo is and description is required" });
  }

  try {
    const addTodo = await Todo.create(req.body);

    if (!addTodo) {
      return res.status(500).json({ error: "internal server error" });
    }
    todos.push(addTodo);
    res.json(addTodo);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const updateTodo = async (req, res) => {
  console.log("update");
  const { todoId } = req.body;
  try {
    const updateTodo = await Todo.findByIdAndUpdate(todoId, req.body, {
      new: true,
    });

    if (!updateTodo) {
      return res.status(404).json({ error: "todo not found" });
    }
    todos =
      todos &&
      todos.map((todo) => (String(todo._id) === todoId ? updateTodo : todo));
    res.json({ updateTodo });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const deletTodo = async (req, res) => {
  const { id } = req.params;
  console.log("delete");

  try {
    const findTodo = await Todo.findByIdAndDelete(id);
    if (!findTodo) {
      return res.status(400).json({ error: " todo not found" });
    }
    todos = todos && todos.filter((todo) => String(todo._id) !== id);

    res.json("todo deleted successfully");
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const getAllTodos = async (req, res) => {
  try {
    const totalTodos = await Todo.countDocuments();

    if (todos.length > 0) {
      return res.json(todos);
    }
    const getTodos = await Todo.find();
    if (totalTodos > todos.length) {
      todos = getTodos;
    }
    res.json(getTodos);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
export { createTodo, updateTodo, deletTodo, getAllTodos };
