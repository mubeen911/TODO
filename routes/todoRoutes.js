import express from "express";
import { createTodo, deletTodo, getAllTodos, updateTodo } from "../controllers/todo_controller.js";

const router=express()
router.post("/create", createTodo)
.post("/update", updateTodo)
.get("/delete/:id", deletTodo)
.get("/get_todos", getAllTodos)

export default router