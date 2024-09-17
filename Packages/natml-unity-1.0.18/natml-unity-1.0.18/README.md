# NatML

![NatML](.media/wall.png)

NatML allows developers to integrate machine learning into their Unity applications in under five lines of code with zero infrastructure. NatML completely removes the need to have any experience with machine learning in order to take advantage of the features it can provide. Features include:

- **Universal Machine Learning**. With NatML, you can drop CoreML (`.mlmodel`), TensorFlow Lite (`.tflite`), and ONNX (`.onnx`) models directly into your Unity project and run them.

- **Bare Metal Performance**. NatML takes advantage of hardware machine learning accelerators, like CoreML on iOS and macOS, NNAPI on Android, and DirectML on Windows. As a result, it is [multiple times faster](https://github.com/natmlx/ML-Bench) than Unity's own Barracuda engine.

- **Cross Platform**. NatML supports Android, iOS, macOS, WebGL, and Windows alike. As a result, you can build your app once, test it in the Editor, and deploy it various platforms and devices all in one seamless workflow.

- **Extremely Easy to Use**. NatML exposes machine learning models with simple classes that return familiar data types. These are called "Predictors", and they handle all of the heavy lifting for you. No need to write pre-processing scripts or shaders, wrangle tensors, or anything of that sort.

- **Growing Catalog**. NatML is designed with a singular focus on applications. As such, we maintain a growing catalog of predictors that developers can quickly discover and deploy in their applications. [Check out NatML Hub](https://hub.natml.ai).

- **Augmented Reality**. NatML is particularly suited for augmented reality because it delegates work to ML accelerators, freeing up the GPU to render your app smoothly.

- **Lightweight Package**. NatML is distributed in a self-contained package, with no external dependencies. As a result, you can simply import the package and get going--no setup necessary.

## Installing NatML
Add the following items to your Unity project's `Packages/manifest.json`:
```json
{
  "scopedRegistries": [
    {
      "name": "NatML",
      "url": "https://registry.npmjs.com",
      "scopes": ["ai.natml"]
    }
  ],
  "dependencies": {
    "ai.natml.natml": "1.0.18"
  }
}
```

## Using ML Models

![drag and drop](.media/mobilenet.gif)

If you have a CoreML, ONNX, or TensorFlow Lite model, you can simply drag and drop it into your project. [See the documentation for more details](https://docs.natml.ai/unity/workflows/models).

> Note that specific model formats can only be used on specific platforms. CoreML models can only be used on iOS and macOS; ONNX can only be used on Windows; and TensorFlow Lite can only be used on Android. Use [NatML Hub](https://hub.natml.ai) to convert your model to different ML formats.

## Discover ML Models on NatML Hub
**[Create an account on NatML Hub](https://hub.natml.ai/profile)** to find and download ML predictors to use in your project!

![NatML Hub](.media/hub.png)

You can also [upload your models to Hub](https://hub.natml.ai/create) and make them private or public. [Check out the documentation](https://docs.natml.ai/unity/api/mlmodel/mledgemodel) for information on writing predictors for your models.

## Using ML Models in Three Simple Steps
You will always use NatML in three steps. First, create a **model** from model data. Model data can either be fetched from [NatML Hub](https://hub.natml.ai) or created from raw ML model files in your project (`.mlmodel`, `.tflite`, and `.onnx`):
```csharp
// Fetch model data from NatML
var accessKey = "<HUB ACCESS KEY>"; // Get your access key from https://hub.natml.ai/profile
var modelData = await MLModelData.FromHub("@author/some-model", accessKey);
// Deserialize the model
var model = modelData.Deserialize();
```

Then create a **predictor** to make predictions with the model:
```csharp
// Create a predictor for the model
var predictor = new SomePredictor(model);
```

Finally, make predictions with the predictor:
```csharp
// Make prediction on an image
Texture2D input = ...;
var someOutput = predictor.Predict(input);
```

Different predictors accept and produce different data types, but the usage pattern will always be the same.

___

## Requirements
- Unity 2021.2+

## Supported Platforms
- Android API Level 24+
- iOS 13+
- macOS 10.15+ (Apple Silicon and Intel)
- Windows 10+ (64-bit only)
- WebGL:
  - Chrome 91+
  - Firefox 90+

## Resources
- Join the [NatML community on Discord](https://hub.natml.ai/community).
- See the [NatML documentation](https://docs.natml.ai/unity).
- Check out [NatML on GitHub](https://github.com/natmlx).
- Read the [NatML blog](https://blog.natml.ai/).
- Discuss [NatML on Unity Forums](https://forum.unity.com/threads/open-beta-natml-machine-learning-runtime.1109339/).
- Contact us at [hi@natml.ai](mailto:hi@natml.ai).

Thank you very much!