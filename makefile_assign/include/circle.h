#ifndef CIRC
#define CIRC

typedef struct _circle Circle;

struct _circle {
	float rad;
};

float circ_area(Circle *c);
float circ_perimtr(Circle *c);
// just a dummy change
//
#endif
