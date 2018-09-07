import express from "express";
import Controller from "./usersController";

const usersResource = express.Router();
const controller = new Controller();

usersResource.post("/sign_in", (req, res, next) => {
    controller.validateLogin(req, res, next);
});

usersResource.get("/user_data", (req, res, next) => {
    controller.getUserData(req, res, next);
});

usersResource.patch("/users_patch", (req, res, next) => {
    controller.changeUserData(req, res, next);
});

export default usersResource;
