const User = require('./../models/userModel.js')

exports.getAllUsers = async (request, response) => {
    try {
        console.log('here');
        const users = await User.find();

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

exports.createUser = (request, response) => {

}