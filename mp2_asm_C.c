#include <stdio.h>
#include <stdlib.h>

// Function prototype for the assembly function
extern void imgCvtGrayFloatToInt(int height, int width, float* imageValues, float* newPixelValues);

int main(){

	int height, width;
    int i, j;

    // Prompt user for height and width of the image
    printf("Enter height and width of the image: ");
    scanf("%d %d", &height, &width);

    // Since the specs indicate single precision floating point values, we use float
    float imageValues[height][width];

    // Allocate memory for new pixel values
    // We will store the converted pixel values as integers
    int* newPixelValues = (int*)malloc(height * width * sizeof(int));

    // Prompt user for pixel values
    printf("Enter the pixel values for the image (as floats):\n");
    for (i = 0; i < height; i++) {
        for (j = 0; j < width; j++) {
            scanf("%f", &imageValues[i][j]);
        }
    }

    // Call the assembly function to convert pixel values
    imgCvtGrayFloatToInt(height, width, (float*)imageValues, newPixelValues);

    // Print the converted pixel values
    printf("Converted pixel values:\n");
    for (i = 0; i < height; i++) {
        for (j = 0; j < width; j++) {
            printf("%d ", newPixelValues[i * width + j]);
        }
        printf("\n");
    }

    // Free allocated memory
    free(newPixelValues);
	
	return 0;
}
