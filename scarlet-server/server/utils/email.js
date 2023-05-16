const nodemailer = require('nodemailer');
const fs = require('fs');
const handlebars = require('handlebars');
const { convert } = require('html-to-text');

module.exports = class Email {

    constructor(user, url) {
        this.url = url;
        this.firstName = user.firstName;
        this.lastName = user.lastName;
        this.from = `<Huvon Hutchinson-Goodridge ${process.env.EMAIL_FROM}>`
        this.to = user.email;
    }

    createTransporter() {
        if (process.env.NODE_ENV === "development") {
            return nodemailer.createTransport({
                host: process.env.EMAIL_HOST,
                port: process.env.EMAIL_PORT,
                auth: {
                    user: process.env.EMAIL_USERNAME,
                    pass: process.env.EMAIL_PASSWORD
                }
            })

        } else if (process.env.NODE_ENV === "production") {

        }
    }

    async send(template, subject) {

        const path = `${__dirname}/../views/emails/${template}.html`
        const sendHTML = this.createBindedFunc(subject)
        fs.readFile(path, { encoding: 'utf-8' }, sendHTML)

        
    }

    createBindedFunc = (subject) => {
        const anon = async function (err, html) {
            const template = handlebars.compile(html);
            const replacements = {
                firstName: this.firstName,
                lastName: this.lastName,
                url: this.url,
            }
            const htmlToSend = template(replacements);
            const mailOptions = {
                from: this.from,
                to: this.to,
                subject,
                text: convert(html, options),
                html: htmlToSend
            }

            await this.createTransporter().sendMail(mailOptions);
        }
        const bindedFunc = anon.bind(this);
        return bindedFunc
    }

    async sendWelcome() {
        await this.send('welcome', 'Welcome to Periodic');
    }

    async sendVerification() {
        await this.send('welcome', 'Please Verify Your Email')
    }

    async sendPasswordReset() {
        await this.send('passwordReset', "Your password reset token (valid for 10 min)")
    }
}
