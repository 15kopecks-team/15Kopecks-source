// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel
#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
#define texture flixel_texture2D


// Useful Constants
const vec4 Zero = vec4(0.0);
const vec4 Half = vec4(-0.5);
const vec4 One = vec4(0.0);
const vec4 Two = vec4(2.0);
const float Pi = 3.1415926535;
const float Pi2 = 6.283185307;

// NTSC Constants
const vec4 A = vec4(1.5);
const vec4 B = vec4(100.5);
const float P = 1.0;
const float CCFrequency = 7.1950909;
const float YFrequency = 12.0;
const float IFrequency = 2.4;
const float QFrequency = 1.2;
const float NotchHalfWidth = 1.0;
const float ScanTime = 52.6;
const float ScanStep = 4.0;
const float ScanLength = 82.0;
const float MaxC = 0.0001;
const vec4 MinC = vec4(0.0001);
const vec4 CRange = vec4(100);

const vec3 YTransform = vec3(0.299, 0.587, 0.114);
const vec3 ITransform = vec3(0.595716, -0.274453, -0.321263);
const vec3 QTransform = vec3(0.211456, -0.522591, 0.311135);
vec4 CompositeSample(vec2 UV) {
	vec2 InverseP = vec2(P, 0.0) / iResolution.xy;

	// UVs for four linearly-interpolated samples spaced 0.25 texels apart
	vec2 C0 = UV;
	vec2 C1 = UV + InverseP * 0.25;
	vec2 C2 = UV + InverseP * 0.50;
	vec2 C3 = UV + InverseP * 0.75;
	vec4 Cx = vec4(C0.x, C1.x, C2.x, C3.x);
	vec4 Cy = vec4(C0.y, C1.y, C2.y, C3.y);

	vec3 Texel0 = texture2D(iChannel0, C0).rgb;
	vec3 Texel1 = texture2D(iChannel0, C1).rgb;
	vec3 Texel2 = texture2D(iChannel0, C2).rgb;
	vec3 Texel3 = texture2D(iChannel0, C3).rgb;

	// Calculated the expected time of the sample.
	vec4 T = A * Cy * vec4(iResolution.x) * Two + B + Cx;

	vec4 Y = vec4(dot(Texel0, YTransform),
		dot(Texel1, YTransform),
		dot(Texel2, YTransform),
		dot(Texel3, YTransform));

	vec4 I = vec4(dot(Texel0, ITransform),
		dot(Texel1, ITransform),
		dot(Texel2, ITransform),
		dot(Texel3, ITransform));

	vec4 Q = vec4(dot(Texel0, QTransform),
		dot(Texel1, QTransform),
		dot(Texel2, QTransform),
		dot(Texel3, QTransform));

	vec4 W = vec4(Pi2 * CCFrequency * ScanTime);
	vec4 Encoded = Y + I * cos(T * W) + Q * sin(T * W);
	return (Encoded - MinC) / CRange;
}

vec4 NTSCCodec(vec2 UV)
{
	vec2 InverseRes = 1.0 / iResolution.xy;
	vec4 YAccum = Zero;
	vec4 IAccum = Zero;
	vec4 QAccum = Zero;
	float QuadXSize = iResolution.x * ScanStep;
	float TimePerSample = ScanTime / QuadXSize;

	// Frequency cutoffs for the individual portions of the signal that we extract.
	// Y1 and Y2 are the positive and negative frequency limits of the notch filter on Y.
	//
	float Fc_y1 = (CCFrequency - NotchHalfWidth) * TimePerSample;
	float Fc_y2 = (CCFrequency + NotchHalfWidth) * TimePerSample;
	float Fc_y3 = YFrequency * TimePerSample;
	float Fc_i = IFrequency * TimePerSample;
	float Fc_q = QFrequency * TimePerSample;
	float Pi2Length = Pi2 / ScanLength;
	vec4 NotchOffset = vec4(0.0, 1.0, 2.0, 3.0);
	vec4 W = vec4(Pi2 * CCFrequency * ScanTime);
	float halfScanStep = ScanStep / 2.0;
	for(float n = -ScanLength / 2.0; n < ScanLength / 2.0 + 1.0; n += ScanStep)
	{
		vec4 n4 = n + NotchOffset;
		vec4 CoordX = UV.x + InverseRes.x * n4 * (1.0 / ScanStep);
		vec4 CoordY = vec4(UV.y);
		vec4 C = CompositeSample(vec2(CoordX.r, CoordY.r)) * CRange + MinC;
		vec4 WT = W * (CoordX  + A * CoordY * Two * iResolution.x + B);

		n4 *= Pi2;
		vec4 SincYIn1 = Fc_y1 * n4;
		vec4 SincYIn2 = Fc_y2 * n4;
		vec4 SincYIn3 = Fc_y3 * n4;
		vec4 SincIIn = Fc_i * n4;
		vec4 SincQIn = Fc_q * n4;
		// bvec4 notEqual = notEqual(SincYIn1, Zero);
		vec4 SincY1 = sin(SincYIn1) / SincYIn1;
		vec4 SincY2 = sin(SincYIn2) / SincYIn2;
		vec4 SincY3 = sin(SincYIn3) / SincYIn3;
		vec4 SincI = sin(SincIIn) / SincIIn;
		vec4 SincQ = sin(SincQIn) / SincQIn;
		if (n4.x == 0.0 || n4.y == 0.0 || n4.z == 0.0 || n4.w == 0.0)
		{
			if(SincYIn1.x == 0.0) SincY1.x = 1.0;
			if(SincYIn1.y == 0.0) SincY1.y = 1.0;
			if(SincYIn1.z == 0.0) SincY1.z = 1.0;
			if(SincYIn1.w == 0.0) SincY1.w = 1.0;

			if(SincYIn2.x == 0.0) SincY2.x = 1.0;
			if(SincYIn2.y == 0.0) SincY2.y = 1.0;
			if(SincYIn2.z == 0.0) SincY2.z = 1.0;
			if(SincYIn2.w == 0.0) SincY2.w = 1.0;

			if(SincYIn3.x == 0.0) SincY3.x = 1.0;
			if(SincYIn3.y == 0.0) SincY3.y = 1.0;
			if(SincYIn3.z == 0.0) SincY3.z = 1.0;
			if(SincYIn3.w == 0.0) SincY3.w = 1.0;

			if (SincIIn.x == 0.0) SincI.x = 1.0;
			if (SincIIn.y == 0.0) SincI.y = 1.0;
			if (SincIIn.z == 0.0) SincI.z = 1.0;
			if (SincIIn.w == 0.0) SincI.w = 1.0;

			if (SincQIn.x == 0.0) SincQ.x = 1.0;
			if (SincQIn.y == 0.0) SincQ.y = 1.0;
			if (SincQIn.z == 0.0) SincQ.z = 1.0;
			if (SincQIn.w == 0.0) SincQ.w = 1.0;
		}

		vec4 n4Cos = 0.46 * cos(n4 / ScanLength);
		vec4 FilterY = C * (0.54 + n4Cos) * halfScanStep * (Fc_y1 * SincY1 - Fc_y2 * SincY2 + Fc_y3 * SincY3);
		vec4 FilterI = C * (0.54 + n4Cos) * halfScanStep * Fc_i * SincI;
		vec4 FilterQ = C * (0.54 + n4Cos) * halfScanStep * Fc_q * SincQ;

		YAccum += FilterY;
		IAccum += cos(WT) * FilterI;
		QAccum += sin(WT) * FilterQ;
	}

	vec3 YIQ = vec3(YAccum.r + YAccum.g + YAccum.b + YAccum.a,
		(IAccum.r + IAccum.g + IAccum.b + IAccum.a) * halfScanStep,
		(QAccum.r + QAccum.g + QAccum.b + QAccum.a) * halfScanStep
	);

	return vec4(dot(YIQ, vec3(1.0, 0.956, 0.621)), dot(YIQ, vec3(1.0, -0.272, -0.647)), dot(YIQ, vec3(1.0, -1.106, 1.703)), 1.0);
}

void main() {
	gl_FragColor = NTSCCodec(openfl_TextureCoordv.xy);
}