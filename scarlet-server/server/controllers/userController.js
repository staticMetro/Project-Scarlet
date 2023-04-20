const User = require('./../models/userModel')

exports.getAllUsers = async (request, response) => {
    try {
        console.log('here');
        const users = await User.find();
        console.log(users);
        response.status(200).json({
            status: 'success',
            data: {
                users
            }
        })

    } catch (err) {

        response.status(400).json({
            status: "fail",
            message: err
        })
    }

}

exports.getUser = (request, response) => {

    const id = request.params.id * 1;

    const period = Period.find(id);
}

exports.updateUser = (request, response) => {

}

exports.deleteUser = (request, response) => {


}

exports.createUser = async (request, response) => {
    const user = await User.create(request.body);

    response.status(201).json({
        status: "success",
        data: {
            user
        }
    })
}