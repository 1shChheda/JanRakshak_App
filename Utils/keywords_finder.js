const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI('AIzaSyDSwO7YIOz1KUeg_U32OAe6974_z4uAXKc');

async function run() {
  const generationConfig_model1 = {
    maxOutputTokens: 2,
    temperature: 0,
  };

  const model_1 = genAI.getGenerativeModel({ model: "gemini-pro"}, generationConfig_model1);

  let text = 'i cant breath'

  const emergency = `identify and only give (one phrase) emergency from the text as answer - ${text}`

  const result1 = await model_1.generateContent(emergency);
  const response1 = result1.response;
  const problem = response1.text();

  const generationConfig_model2 = {
    maxOutputTokens: 50,
    temperature: 0,
  };

  const model_2 = genAI.getGenerativeModel({ model: "gemini-pro"}, generationConfig_model2);

  const prompt = `The services provided are: 1.Paramedic Services, 2. Police Station, 3. Ambulance Services, 4.Search and Rescue Services. Arrange them (only the title. no description required) as the decreasing order of services which are fastest to access, most helpful, feasible and efficient service for the case of ${problem}`

  const result2 = await model_2.generateContent(prompt);
  const response2 = result2.response;
  const sequence = response2.text();
  console.log(sequence);
  
  return sequence
}

run();