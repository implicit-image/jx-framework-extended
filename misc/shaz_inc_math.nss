// shaz_inc_math
/*
    Math related functions written by Shazbotian
*/


// if no intersection between S1 and S2 exist, puts -1 in the Z of the return vector. 
// else, returns the intersection. this function only checks 2D
vector SegmentIntersectsSegment(vector vS1Start, vector vS1End, vector vS2Start, vector VS2End); 


// if no intersection between S1 and S2 exist, puts -1 in the Z of the return vector. 
// else, returns the intersection. this function only checks 2D
vector SegmentIntersectsSegment(vector vS1Start, vector vS1End, vector vS2Start, vector vS2End)
{
	// coppied this from newsgroups.cryer.info/comp/graphics.algorithms/200603/12/0604283175.html
	vector vDP, vS1, vS2, vReturn;
	float fD, fLA, fLB;

	vDP.x = vS2Start.x - vS1Start.x ;
	vDP.y = vS2Start.y - vS1Start.y ;
	vS1.x = vS1End.x - vS1Start.x;
	vS1.y = vS1End.y - vS1Start.y;
	vS2.x = vS2End.x - vS2Start.x;
	vS2.y = vS2End.y - vS2Start.y;

	fD  =   vS1.y * vS2.x - vS2.y * vS1.x ;
	if(fD == 0.0) {
		//object oPC = GetFirstPC();
		//SendMessageToPC(oPC, "Division by zero averted!!");
		vReturn.z = -1.0f;
		return vReturn;
	} else {
		fLA = ( vS2.x * vDP.y - vS2.y * vDP.x ) / fD ;
		fLB = ( vS1.x * vDP.y - vS1.y * vDP.x ) / fD ;
	}

// if intersection exist   0 <= la  <= 1 and  0 <= lb  <= 1

	if(((fLA >= 0.0f) && (fLA <= 1.0f)) && ((fLB >= 0.0f) && (fLB <= 1.0f))) {
		// interesection
		vReturn.x = vS1Start.x + fLA * vS1.x;
		vReturn.y = vS1Start.y + fLA * vS1.y;
		vReturn.z = 0.0f;
	} else {
		vReturn.z = -1.0f;
	}

	return vReturn;
}