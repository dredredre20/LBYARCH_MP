// to use printf and scanf without warnings
#define _CRT_SECURE_NO_WARNINGS

// include necessary headers
#include <stdio.h>
#include <stdlib.h>

// import assembly function
extern void imgCvtGrayFloatToInt(float inPixel, int* outPixel);

int main() {
    char fileName[100] = { 0 };
    int height = 0, width = 0;

    // ask for file name
    printf("Enter file name: ");
    if (scanf("%99s", fileName) != 1) {
        printf("Error reading file name input.\n");
        return 1;
    }

    // open file
    FILE* file = fopen(fileName, "r");
    if (file == NULL) {
        printf("Error opening file: %s\n", fileName);
        return 1;
    }

    // read height and width
    if (fscanf(file, "%d", &height) != 1) {
        printf("Error: Could not read height.\n");
        return 1;
    }
    if (fscanf(file, "%d", &width) != 1) {
        printf("Error: Could not read width.\n");
        return 1;
    }

    // allocate 2D float array for pixels
    float** pixels = (float**)malloc(height * sizeof(float*));
    if (pixels == NULL) {
        printf("Error allocating memory for pixel rows.\n");
        return 1;
    }

    for (int i = 0; i < height; i++) {
        pixels[i] = (float*)malloc(width * sizeof(float));
        if (pixels[i] == NULL) {
            printf("Error allocating memory for row %d.\n", i);
            return 1;
        }
        for (int j = 0; j < width; j++) {
            if (fscanf(file, "%f", &pixels[i][j]) != 1) {
                printf("Error: Could not read pixel at (%d, %d).\n", i, j);
                return 1;
            }
        }
    }

	fclose(file); // close the file after reading

	// display the input data for checking
    printf("Height: %d\n", height);
	printf("Width: %d\n", width);
    printf("Pixel Values: \n");
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            printf("%.2f ", pixels[i][j]);
        }
        printf("\n");
    }

    // allocate memory for integer output pixels
    int* intPixels = (int*)malloc(height * width * sizeof(int));
    if (intPixels == NULL) {
        printf("Error allocating memory for intPixels.\n");
        return 1;
    }

    // convert using NASM function
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            imgCvtGrayFloatToInt(pixels[i][j], &intPixels[i * width + j]);
        }
    }

    // display result
    printf("\nConverted Integer Pixels:\n");
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            printf("%3d ", intPixels[i * width + j]);
        }
        printf("\n");
    }

    // free memory
    for (int i = 0; i < height; i++) {
        free(pixels[i]);
    }
    free(pixels);
    free(intPixels);

    return 0;
}


