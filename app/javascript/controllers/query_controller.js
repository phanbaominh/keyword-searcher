import { Controller } from '@hotwired/stimulus';
import Chart from 'chart.js/auto';
// let ei = 0;
// function randomElection(name = `Election_${ei}`) {
//   return { name, id: ei };
// }
// let pi = 0;
// function randomP(name = `Party_${pi}`) {
//   return { name, id: pi++ };
// }

// function randomER(votes = 1) {
//   return { votes, election: randomElection(), party: randomP() };
// }
// Connects to data-controller="query"
export default class extends Controller {
  static targets = ['result'];
  connect() {
    console.log('Hello!');
  }
  displayResult(event) {
    console.log('Display!', event.detail);
    const elections = new Map();
    const parties = new Map();
    const queryResult = event.detail[0];
    // const queryResult = [randomER(), randomER()];
    queryResult.forEach((electionResult) => {
      const election = electionResult.election;
      const party = electionResult.party;
      if (elections.has(election.id)) {
        elections.get(election.id).result.push(electionResult);
      } else {
        elections.set(election.id, { ...election, result: [electionResult] });
      }
      if (parties.has(party.id)) {
        parties.get(party.id).result.push(electionResult);
      } else {
        parties.set(party.id, { ...party, result: [electionResult] });
      }
    });
    elections.forEach((election) => {
      if (election.result.length > 1) {
        const canvas = $('<canvas></canvas>');

        $(this.resultTarget).append(canvas);
        const data = {
          labels: election.result.map((result) => result.party.name),
          datasets: [
            {
              label: `${election.name} result`,
              data: election.result.map((result) => result.votes),
              // backgroundColor: [
              //   'rgba(255, 99, 132, 0.2)',
              //   'rgba(54, 162, 235, 0.2)',
              //   'rgba(255, 206, 86, 0.2)',
              //   'rgba(75, 192, 192, 0.2)',
              //   'rgba(153, 102, 255, 0.2)',
              //   'rgba(255, 159, 64, 0.2)',
              // ],
              // borderColor: [
              //   'rgba(255, 99, 132, 1)',
              //   'rgba(54, 162, 235, 1)',
              //   'rgba(255, 206, 86, 1)',
              //   'rgba(75, 192, 192, 1)',
              //   'rgba(153, 102, 255, 1)',
              //   'rgba(255, 159, 64, 1)',
              // ],
              borderWidth: 1,
            },
          ],
        };

        console.log(data);
        new Chart(canvas, {
          type: 'bar',
          data,
          options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
              y: {
                beginAtZero: true,
              },
            },
          },
        });
      }
    });
  }
}
