import jwt from "jsonwebtoken";

const MOCKED_LOGIN = "@a";
const MOCKED_PASSWORD = "12345678";

const user = {
    email: MOCKED_LOGIN,
    password: MOCKED_PASSWORD,
};

class Controller {

    async validateLogin(req, res, next) {
        const { email, password } = req.body;
        if(!email || !password)
            return res.status(422).send({ msg: "Missing login attributes." });

        if(email === MOCKED_LOGIN && password === MOCKED_PASSWORD) {
            const payload = {
                email: email,
            };
            const config = {
                expiresIn: '240h',
            };
            const authToken =  jwt.sign(payload, process.env.AUTH_SECRET, config);

            const currentUser = {
                email: user.email,
                password: user.password,
            };

            currentUser.token = authToken;
            return res.status(200).json(currentUser);
        }
        return res.status(403).json({ msg: "Invalid login and password." });
    }

    async getUserData(req, res, next) {
        const givenToken = req.get("Authorization");
        console.log("Given token: " + givenToken);
        if(!givenToken)
            return res.status(401).json({ msg: "Missing Authorization." });
        try {
            const tokenPayload = jwt.verify(givenToken, process.env.AUTH_SECRET);
            return res.status(200).json(user);
        } catch (e) {
            return res.status(401).json({ msg:"Unauthorized." });
        }
    }

    async changeUserData(req, res, next) {
        const givenToken = req.get("Authorization");
        console.log("Given token: " + givenToken);
        if(!givenToken)
            return res.status(401).json({ msg: "Missing Authorization." });
        try {
            const tokenPayload = jwt.verify(givenToken, process.env.AUTH_SECRET);
            const { name, email, password } = req.body;
            if(name)
                user.name = name;
            if(email)
                user.email = email;
            if(password)
                user.password = password;
            return res.status(200).json(user);
        } catch (e) {
            return res.status(401).json({ msg: "Operation Unauthorized" });
        }
    }
}

export default Controller;
