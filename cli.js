const inquirer = require('inquirer');
const chalk = require('chalk');
const figlet = require('figlet');
const fs = require('fs');
const Configstore = require('configstore');
const ejs = require('ejs');

const config = new Configstore('ffgenStore');

const intro = () => {
    console.log(chalk.yellow(figlet.textSync('FF is Easy')));
    console.log(chalk.gray('Generate Your ChangeSets'));
};

module.exports = async () => {
    intro();
    prompt();
};

async function prompt() {

    const templateVars = {};

    let ffAuthorStored = config.get('ffAuthor');
    let ffAuthor = await inquirer.prompt({
        type: 'input',
        name: 'ffAuthor',
        default: ffAuthorStored,
        message: 'ChangeSet Author:',
    });
    templateVars['ffAuthor'] = ffAuthor['ffAuthor'];
    config.set('ffAuthor', ffAuthor['ffAuthor']);

    let ffSprintNumberStored = config.get('ffSprintNumber');
    let ffSprintNumber = await inquirer.prompt({
        type: 'input',
        name: 'ffSprintNumber',
        default: ffSprintNumberStored,
        message: 'Sprint Number:',
    });
    templateVars['ffSprintNumber'] = ffSprintNumber['ffSprintNumber'];
    config.set('ffSprintNumber', ffSprintNumber['ffSprintNumber']);

    let ffName = await inquirer.prompt({
        type: 'input',
        name: 'ffName',
        message: 'FF Name (example: SMRT-1111.xxx.enabled):',
    });
    templateVars['ffName'] = ffName['ffName'];

    let ffDescription = await inquirer.prompt({
        type: 'input',
        name: 'ffDescription',
        message: 'FF Description (example: SMRT-1111 Новая услуга)',
    });
    templateVars['ffDescription'] = ffDescription['ffDescription'];

    let ffType = await inquirer.prompt({
        type: 'list',
        name: 'ffType',
        message: 'Select FF Type:',
        default: 'RELEASE',
        choices: [{
            name: 'RELEASE',
            value: 'RELEASE'
        }, {
            name: 'SYSTEM',
            value: 'SYSTEM'
        }]
    });
    templateVars['ffType'] = ffType['ffType'];

    let ffTag = await inquirer.prompt({
        type: 'list',
        name: 'ffTag',
        message: 'Select FF Tag(optional):',
        default: '<none>',
        choices: [{
            name: '<none>',
            value: '<none>'
        }, {
            name: 'WEB',
            value: 'WEB'
        }, {
            name: 'TEST',
            value: 'TEST'
        }, {
            name: 'MOBILE',
            value: 'MOBILE'
        }]
    });
    templateVars['ffTag'] = ffTag['ffTag'];

    templateVars['ffNumber'] = ffName['ffName'].split('.')[0];

    let templateBody = fs.readFileSync(__dirname + '/changeset.tpl', 'utf8');
    let template = ejs.compile(templateBody);
    let out = template(templateVars);

    console.log(out);

    fs.writeFileSync('changeSet.xml', out);
};
