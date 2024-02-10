const { GoogleGenerativeAI } = require("@google/generative-ai");
require('dotenv').config();
const genAI = new GoogleGenerativeAI(process.env.OPEN_AI_KEY);

const text_to_widget = async(transcribed_text) => {
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

    const prompt = `The services provided are: 1. Fire Department, 2. Police Station, 3. Ambulance Services, 4.Search and Rescue Services. Arrange them (only the title. no description required) as the decreasing order of services which are fastest to access, most helpful, feasible and efficient service for the case of ${problem}. IMPORTANT NOTE: ANSWER SHOULD ONLY INCLUDE ABOVE LISTED OPTIONS.`

    const result2 = await model_2.generateContent(prompt);
    const response2 = result2.response;
    const sequence = response2.text();
    console.log(sequence);

    

    return sequence
}

module.exports = text_to_widget;