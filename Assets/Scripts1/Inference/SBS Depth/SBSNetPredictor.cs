namespace NatML.Vision {

    using System;
    using UnityEngine;
    using NatML.Features;
    using NatML.Internal;
    using NatML.Types;

    /// <summary>
    /// Hair Matte Net hair segmentation.
    /// </summary>
    public sealed partial class SBSNetPredictor : IMLPredictor<SBSNetPredictor.Matte> {

        #region --Client API--
        /// <summary>
        /// Create depth predictor.
        /// </summary>
        /// <param name="model">Depth Net ML model.</param>
        public SBSNetPredictor (MLModel model) => this.model = model as MLEdgeModel;

        /// <summary>
        /// Depth map of image.
        /// </summary>
        /// <param name="inputs">Input image.</param>
        /// <returns>Hair segmentation map.</returns>
        public Matte Predict (params MLFeature[] inputs) {
            // Check
            if (inputs.Length != 2)
                throw new ArgumentException(@"Depth predictor expects two features", nameof(inputs));
            // Check type
            var input1 = inputs[0];
            var input2 = inputs[1];
            //Debug.Log(input.type);
            if (!MLImageType.FromType(input1.type) || !MLImageType.FromType(input2.type))
                throw new ArgumentException(@"Depth predictor expects an an array or image feature", nameof(inputs));
            // Predict
            var inputTypeL = model.inputs[0];
            var inputTypeR = model.inputs[1];

            using var inputFeatureL = (input1 as IMLEdgeFeature).Create(inputTypeL);
            using var inputFeatureR = (input2 as IMLEdgeFeature).Create(inputTypeR);
            using var outputFeatures = model.Predict(inputFeatureL, inputFeatureR);
            
            var matte = new MLArrayFeature<float>(outputFeatures[0]);

            int width = matte.shape[3];
            int height = matte.shape[2];
            
            var result = new Matte(width, height, matte.ToArray());

            return result;
        }
        #endregion


        #region --Operations--
        private readonly MLEdgeModel model;

        void IDisposable.Dispose () { }
        #endregion
    }
}