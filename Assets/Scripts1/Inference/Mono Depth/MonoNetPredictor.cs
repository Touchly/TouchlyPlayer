namespace NatML.Vision {

    using System;
    using UnityEngine;
    using NatML.Features;
    using NatML.Internal;
    using NatML.Types;

    /// <summary>
    /// Hair Matte Net hair segmentation.
    /// </summary>
    public sealed partial class MonoNetPredictor : IMLPredictor<MonoNetPredictor.Matte> {

        #region --Client API--
        /// <summary>
        /// Create depth predictor.
        /// </summary>
        /// <param name="model">Depth Net ML model.</param>
        public MonoNetPredictor (MLModel model) => this.model = model as MLEdgeModel;

        /// <summary>
        /// Depth map of image.
        /// </summary>
        /// <param name="inputs">Input image.</param>
        /// <returns>Hair segmentation map.</returns>
        public Matte Predict (params MLFeature[] inputs) {
            // Check
            if (inputs.Length != 1)
                throw new ArgumentException(@"Depth predictor expects one feature", nameof(inputs));

            var input = inputs[0];

            if (!MLImageType.FromType(input.type))
                throw new ArgumentException(@"Depth predictor expects an an array or image feature", nameof(inputs));
            // Predict
            var inputType = model.inputs[0];
            
            using var inputFeature = (input as IMLEdgeFeature).Create(inputType);
            using var outputFeatures = model.Predict(inputFeature);
            
            // TCMonoDepth
            var matte = new MLArrayFeature<float>(outputFeatures[0]);
            var result = new Matte(matte.shape[3], matte.shape[2], matte.ToArray());

            // Return
            return result;
        }
        #endregion


        #region --Operations--
        private readonly MLEdgeModel model;

        void IDisposable.Dispose () { }
        #endregion
    }
}