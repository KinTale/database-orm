/*
  Warnings:

  - The primary key for the `Screening` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Screening` table. All the data in the column will be lost.
  - You are about to drop the column `movieId` on the `Screening` table. All the data in the column will be lost.
  - You are about to drop the column `screenId` on the `Screening` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[title]` on the table `Movie` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[number]` on the table `Screen` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[movieName]` on the table `Screening` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `movieName` to the `Screening` table without a default value. This is not possible if the table is not empty.
  - Added the required column `screenNumber` to the `Screening` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Screening" DROP CONSTRAINT "Screening_movieId_fkey";

-- DropForeignKey
ALTER TABLE "Screening" DROP CONSTRAINT "Screening_screenId_fkey";

-- DropIndex
DROP INDEX "Screening_movieId_key";

-- AlterTable
ALTER TABLE "Screening" DROP CONSTRAINT "Screening_pkey",
DROP COLUMN "id",
DROP COLUMN "movieId",
DROP COLUMN "screenId",
ADD COLUMN     "movieName" TEXT NOT NULL,
ADD COLUMN     "screenNumber" INTEGER NOT NULL,
ADD CONSTRAINT "Screening_pkey" PRIMARY KEY ("movieName", "startsAt", "screenNumber");

-- CreateTable
CREATE TABLE "Ticket" (
    "id" SERIAL NOT NULL,
    "customerID" INTEGER NOT NULL,
    "movieName" TEXT NOT NULL,
    "movieStartTime" TIMESTAMP(3) NOT NULL,
    "screenNumber" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ticket_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Movie_title_key" ON "Movie"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Screen_number_key" ON "Screen"("number");

-- CreateIndex
CREATE UNIQUE INDEX "Screening_movieName_key" ON "Screening"("movieName");

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_customerID_fkey" FOREIGN KEY ("customerID") REFERENCES "Customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_movieName_movieStartTime_screenNumber_fkey" FOREIGN KEY ("movieName", "movieStartTime", "screenNumber") REFERENCES "Screening"("movieName", "startsAt", "screenNumber") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Screening" ADD CONSTRAINT "Screening_movieName_fkey" FOREIGN KEY ("movieName") REFERENCES "Movie"("title") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Screening" ADD CONSTRAINT "Screening_screenNumber_fkey" FOREIGN KEY ("screenNumber") REFERENCES "Screen"("number") ON DELETE RESTRICT ON UPDATE CASCADE;
