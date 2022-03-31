const { PrismaClient } = require('@prisma/client');
const { create } = require('json-server');
const prisma = new PrismaClient();

async function seed() {
    const createdCustomer = await prisma.customer.create({
        data: {
            name: "Alice",
            contact: {
                create: {
                    phone: 0999955599,
                    email: "email@email.com",
                },
            },
        },
        include: {
            contact: true,
        },
    });

    console.log('Customer created', createdCustomer);
    const createScreen1 = await prisma.screen.create({
        data: {
            number: 1
        }
    })


    const createdMovie1 = await prisma.movie.create({
        data: {
            title: 'Titanic',
            runtimeMins: 180,
            Screening: {
                create: {
                    startsAt: new Date(1998, 0, 23, 10, 05, 0, 0),
                    screenNumber: createScreen1.number
                }
            }
        },
        include: {
            Screening: true
        }

    })

    const createScreen2 = await prisma.screen.create({
        data: {
            number: 2
        }
    })

    const createdMovie2 = await prisma.movie.create({
        data: {
            title: 'Your lie in april',
            runtimeMins: 380,
            Screening: {
                create: {
                    startsAt: new Date(2019, 0, 23, 10, 05, 0, 0),
                    screenNumber: createScreen2.number
                }
            }
        },
        include: {
            Screening: true
        }

    })

    console.log('add movie', createdMovie1)
    console.log('add movie', createdMovie2)

    const createTicket = await prisma.ticket.create({
		data: {
			movie: {
				connect: {
					movieName: createdMovie2.title
                 
				},
			},
			customer: {
				connect: {
					id: createdCustomer.id,
				},
			},
		},
	});
    console.log('TICKET', createTicket)
    // Don't edit any of the code below this line
    process.exit(0);
}

seed()
    .catch(async (error) => {
        console.error(error);
        await prisma.$disconnect();
        process.exit(1);
    })
