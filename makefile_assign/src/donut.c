#include <donut.h>
#include <stdlib.h>
#include <stdio.h>
#include <circle.h>

void read_donut(Donut * d){
	printf("Input inner and outer radii: ");
	scanf("%f",&((d->inner).rad));
	scanf("%f",&((d->outer).rad));

	if((d->inner).rad >= ((d->outer).rad)){
		fprintf(stderr, "Invalid donut\n");
		exit(-1);
	}
}

float donut_peri(Donut * d){
	return circ_perimtr(&(d->inner)) + circ_perimtr(&(d->outer));
}

float donut_area(Donut * d){
	return circ_area(&(d->outer))-circ_area(&(d->inner));
}

