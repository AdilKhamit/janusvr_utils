﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using UnityEngine;

namespace JanusVR
{
    public class AssetObject : JanusAsset
    {
        [XmlIgnore]
        public Mesh Mesh { get; set; }
    }
}