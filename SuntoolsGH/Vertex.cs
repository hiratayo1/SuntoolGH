﻿namespace SunTools
{
    using MIConvexHull;
    /// <summary>
    /// A vertex is a simple class that stores the postion of a point, node or vertex.
    /// </summary>
    public class Vertex : IVertex
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="Vertex"/> class.
        /// </summary>
        /// <param name="x">The x position.</param>
        /// <param name="y">The y position.</param>
        /// <param name="z">The z position.</param>
        public Vertex(double x, double y, double z)
        {
            Position = new double[3] { x, y, z };
        }

        public double[] Position { get; set; }
    }
}
