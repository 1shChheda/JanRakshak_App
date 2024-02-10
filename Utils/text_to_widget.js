const { GoogleGenerativeAI } = require("@google/generative-ai");
require('dotenv').config();
const genAI = new GoogleGenerativeAI(process.env.OPEN_AI_KEY);

const text_to_widget = async (transcribed_text) => {
    const generationConfig_model1 = {
        maxOutputTokens: 2,
        temperature: 0,
    };

    const model_1 = genAI.getGenerativeModel({ model: "gemini-pro" }, generationConfig_model1);

    let text = transcribed_text;

    const emergency = `identify and only give (one phrase) emergency from the text as answer - ${text}`

    const result1 = await model_1.generateContent(emergency);
    const response1 = result1.response;
    const problem = response1.text();

    const generationConfig_model2 = {
        maxOutputTokens: 50,
        temperature: 0,
    };

    const model_2 = genAI.getGenerativeModel({ model: "gemini-pro" }, generationConfig_model2);

    const servicesOptions = [
        "Fire Department",
        "Police Station",
        "Ambulance Services",
        "Search and Rescue Services",
        "Paramedics"
    ];

    const prompt = `The services provided are: 1. Fire Department, 2. Police Station, 3. Ambulance Services, 4.Search and Rescue Services, 5. Paramedics. Arrange them (only the title. no description required) as the decreasing order of services which are fastest to access, most helpful, feasible and efficient service for the case of ${problem}. IMPORTANT NOTE: ANSWER SHOULD ONLY INCLUDE ABOVE LISTED OPTIONS.`

    const result2 = await model_2.generateContent(prompt);
    const response2 = result2.response;
    const sequence = response2.text();
    console.log(sequence);

    // Extracting the indexes of services
    const indexes = servicesOptions.map(service => sequence.indexOf(service));

    // Sorting indexes based on their appearance in the sequence
    const sortedIndexes = indexes.slice().sort((a, b) => a - b);

    // Creating a map of service indexes
    const serviceIndexes = sortedIndexes.map(index => indexes.indexOf(index) + 1);

    const priorityIndexes = [serviceIndexes[0],serviceIndexes[1]];
    const optionalIndexes = [serviceIndexes[2],serviceIndexes[3],serviceIndexes[4]];
    return [priorityIndexes, optionalIndexes]; 
    // priority -> by default send Alert
    // optional -> give user the flexibilty to send Alert or not
}

module.exports = text_to_widget;
